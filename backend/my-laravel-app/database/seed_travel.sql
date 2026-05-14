INSERT INTO destinations (name, description, weekly_cost_estimate)
SELECT 'Barcelona', 'Beaches, Gaudi architecture, tapas, and a cheaper mid-range week than most major Western European city breaks.', 910.00
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Barcelona');
UPDATE destinations
SET description = 'Beaches, Gaudi architecture, tapas, and a cheaper mid-range week than most major Western European city breaks.',
    weekly_cost_estimate = 910.00
WHERE name = 'Barcelona';

INSERT INTO destinations (name, description, weekly_cost_estimate)
SELECT 'Tokyo', 'Neon neighborhoods, temples, trains, ramen, and excellent value if you mix budget food with a mid-range hotel.', 980.00
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Tokyo');
UPDATE destinations
SET description = 'Neon neighborhoods, temples, trains, ramen, and excellent value if you mix budget food with a mid-range hotel.',
    weekly_cost_estimate = 980.00
WHERE name = 'Tokyo';

INSERT INTO destinations (name, description, weekly_cost_estimate)
SELECT 'Rome', 'Ancient ruins, walkable historic streets, strong food value, and a mid-range weekly budget below Paris.', 1050.00
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Rome');
UPDATE destinations
SET description = 'Ancient ruins, walkable historic streets, strong food value, and a mid-range weekly budget below Paris.',
    weekly_cost_estimate = 1050.00
WHERE name = 'Rome';

INSERT INTO destinations (name, description, weekly_cost_estimate)
SELECT 'Paris', 'Museums, cafes, metro access, and classic sights, but hotels and restaurants make it the priciest option here.', 1260.00
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Paris');
UPDATE destinations
SET description = 'Museums, cafes, metro access, and classic sights, but hotels and restaurants make it the priciest option here.',
    weekly_cost_estimate = 1260.00
WHERE name = 'Paris';

INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Sagrada Familia', 'Gaudi basilica.' FROM destinations d
WHERE d.name = 'Barcelona' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Sagrada Familia');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Park Guell', 'Gaudi park and city views.' FROM destinations d
WHERE d.name = 'Barcelona' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Park Guell');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Gothic Quarter', 'Old streets and plazas.' FROM destinations d
WHERE d.name = 'Barcelona' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Gothic Quarter');

INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Shibuya Crossing', 'Iconic city crossing.' FROM destinations d
WHERE d.name = 'Tokyo' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Shibuya Crossing');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Senso-ji', 'Historic Asakusa temple.' FROM destinations d
WHERE d.name = 'Tokyo' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Senso-ji');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Meiji Shrine', 'Forest shrine near Harajuku.' FROM destinations d
WHERE d.name = 'Tokyo' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Meiji Shrine');

INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Colosseum', 'Ancient amphitheater.' FROM destinations d
WHERE d.name = 'Rome' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Colosseum');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Vatican Museums', 'Major art collections.' FROM destinations d
WHERE d.name = 'Rome' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Vatican Museums');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Trevi Fountain', 'Historic fountain.' FROM destinations d
WHERE d.name = 'Rome' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Trevi Fountain');

INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Eiffel Tower', 'Classic Paris landmark.' FROM destinations d
WHERE d.name = 'Paris' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Eiffel Tower');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Louvre Museum', 'Major art museum.' FROM destinations d
WHERE d.name = 'Paris' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Louvre Museum');
INSERT INTO attractions (destination_id, name, description)
SELECT d.id, 'Montmartre', 'Hilltop neighborhood and basilica.' FROM destinations d
WHERE d.name = 'Paris' AND NOT EXISTS (SELECT 1 FROM attractions a WHERE a.destination_id = d.id AND a.name = 'Montmartre');
